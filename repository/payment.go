package repository

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
)

type PaymentRepo struct{}

func NewPaymentRepo() *PaymentRepo {
	return &PaymentRepo{}
}
func (s *PaymentRepo) FindAll(db *sql.DB) ([]model.Payment, error) {
	var payments []model.Payment
	query := `select * from "Payment";`
	rows, err := db.Query(query)
	if err != nil {
		return []model.Payment{}, errors.New(" Internal Server Error")
	}
	for rows.Next() {
		var payment model.Payment
		err := rows.Scan(&payment.Id, &payment.Name)
		if err != nil {
			return []model.Payment{}, errors.New(" Internal Server Error")
		}
		payments = append(payments, payment)
	}
	return payments, nil
}
func (s *PaymentRepo) Insert(tx *sql.Tx, response *model.Response, body *model.Transaction) error {
	query := `select "order_code" from "Order" where "order_code" ilike $1;`
	err := tx.QueryRow(query, body.BookingId).Scan(&response.BookingId)
	if err != nil {
		tx.Rollback()
		return errors.New(" Invalid BookingId")
	}
	var paymentId int
	query = `select "id" from "Payment" where replace("name", ' ', '_') ilike $1;`
	err = tx.QueryRow(query, body.PaymentMethod).Scan(&paymentId)
	if err != nil {
		tx.Rollback()
		return errors.New(" Invalid PaymentMethod")
	}
	var transactionId int
	jsonData, _ := json.Marshal(body.PaymentDetails)
	query = `insert into "Transaction" ("transaction_code", "payment_id", "payment_details") values ('TXN-' || nextval('"Transaction_id_seq"')-1, $1, $2) returning id, "transaction_code";`
	err = tx.QueryRow(query, paymentId, jsonData).Scan(&transactionId, &response.TransactionId)
	if err != nil {
		fmt.Println(err)
		tx.Rollback()
		return errors.New(" Internal Server Error")
	}
	query = `update "Order" set "transaction_id"=$1 where "order_code" ilike $2 returning "order_code"`
	err = tx.QueryRow(query, transactionId, body.BookingId).Scan(&response.BookingId)
	if err != nil {
		fmt.Println(err)
		tx.Rollback()
		return errors.New(" Internal Server Error")
	}
	return nil
}
