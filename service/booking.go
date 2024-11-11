package service

import (
	"database/sql"
	"fmt"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/repository"
)

type OrderService struct {
	db   *sql.DB
	repo *repository.OrderRepo
}

func NewOrderService(db *sql.DB, repo *repository.OrderRepo) *OrderService {
	return &OrderService{db, repo}
}

func (s *OrderService) CreateOrder(order *model.Order, userId int) error {
	tx, err := s.db.Begin()
	if err != nil {
		fmt.Println("Tx Begin Error:", err)
		return err
	}
	err = s.repo.Insert(tx, order, userId)
	if err != nil {
		return err
	}
	order.Id = 0
	tx.Commit()
	return nil
}
