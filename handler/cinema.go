package handler

import (
	"encoding/json"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/service"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/utils"
)

type CinemaHandler struct {
	service *service.CinemaService
}

func NewCinemaHandler(service *service.CinemaService) *CinemaHandler {
	return &CinemaHandler{service}
}

func (h *CinemaHandler) GetAll(w http.ResponseWriter, r *http.Request) {
	data, err := h.service.GetAll()
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusInternalServerError, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, model.Response{Data: data}, http.StatusOK, "")
	json.NewEncoder(w).Encode(response)
}
func (h *CinemaHandler) GetById(w http.ResponseWriter, r *http.Request) {
	var cinema model.Cinema
	cinema.Id = utils.ToInt(chi.URLParam(r, "id"))
	if err := h.service.GetById(&cinema); err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusNotFound, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, model.Response{Data: cinema}, http.StatusOK, "")
	json.NewEncoder(w).Encode(response)
}
func (h *CinemaHandler) GetAllSeatsSchedule(w http.ResponseWriter, r *http.Request) {
	id := utils.ToInt(chi.URLParam(r, "id"))
	date := r.URL.Query().Get("date")
	time := r.URL.Query().Get("time")
	data, err := h.service.GetAllSeatsSchedule(id, date, time)
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusNotFound, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, model.Response{Data: data}, http.StatusOK, "")
	json.NewEncoder(w).Encode(response)
}
