package service

import (
	"database/sql"
	"fmt"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/repository"
)

type PaymentService struct {
	db   *sql.DB
	repo *repository.PaymentRepo
}

func NewPaymentService(db *sql.DB, repo *repository.PaymentRepo) *PaymentService {
	return &PaymentService{db, repo}
}

func (s *PaymentService) GetAll() ([]model.Payment, error) {
	payments, err := s.repo.FindAll(s.db)
	if err != nil {
		return []model.Payment{}, err
	}
	return payments, nil
}
func (s *PaymentService) Pay(response *model.Response, body *model.Transaction) error {
	tx, err := s.db.Begin()
	if err != nil {
		fmt.Println("Tx Begin Error:", err)
		return err
	}
	err = s.repo.Insert(tx, response, body)
	if err != nil {
		return err
	}
	tx.Commit()
	return nil
}
