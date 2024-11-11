package router

import (
	"log"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	_ "github.com/lib/pq"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/database"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/handler"
	mid "github.com/train-do/project-app-bioskop-golang-homework-fernando/middleware"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/repository"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/service"
)

func RouterAPI() *chi.Mux {
	db, err := database.InitDB()
	if err != nil {
		log.Fatal(err)
	}
	userRepo := repository.NewUserRepo()
	userService := service.NewUserService(db, userRepo)
	userHandler := handler.NewUserHandler(userService)
	cinemaRepo := repository.NewCinemaRepo()
	cinemaService := service.NewCinemaService(db, cinemaRepo)
	cinemaHandler := handler.NewCinemaHandler(cinemaService)
	paymentRepo := repository.NewPaymentRepo()
	paymentService := service.NewPaymentService(db, paymentRepo)
	paymentHandler := handler.NewPaymentHandler(paymentService)
	orderRepo := repository.NewOrderRepo()
	orderService := service.NewOrderService(db, orderRepo)
	orderHandler := handler.NewOrderHandler(orderService)
	router := chi.NewRouter()
	router.Use(middleware.Logger)
	router.Route("/api", func(r chi.Router) {
		r.Post("/register", userHandler.Register)
		r.Post("/login", userHandler.Login)
		r.Group(func(r chi.Router) {
			r.Use(mid.Authentication(db))
			r.Post("/logout", userHandler.Logout)
			r.Post("/booking", orderHandler.CreateOrder)
			r.Get("/payment-methods", paymentHandler.GetAll)
			r.Post("/pay", paymentHandler.Pay)
			r.Route("/cinemas", func(r chi.Router) {
				r.Get("/", cinemaHandler.GetAll)
				r.Get("/{id}", cinemaHandler.GetById)
				r.Get("/{id}/seats", cinemaHandler.GetAllSeatsSchedule)
			})
		})
	})
	return router
}
