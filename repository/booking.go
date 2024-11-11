package repository

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
)

type OrderRepo struct{}

func NewOrderRepo() *OrderRepo {
	return &OrderRepo{}
}
func (s *OrderRepo) Insert(tx *sql.Tx, order *model.Order, userId int) error {
	query :=
		`
	select css.id, cs.cinema_id, s2."name" as "seat_id", css.status 
	from "CinemaSeatSchedule" css 
	join "Schedule" s on s.id = css.schedule_id 
	join "CinemaSeat" cs on cs.id = css.cinema_seat_id 
	join "Seat" s2 on s2.id = cs.seat_id
	where cs.cinema_id=$1 and s2."name" ilike $2 and s."date"=$3 and s."time"=$4;
	`
	var status string
	// fmt.Println(userId, order.CinemaId, order.SeatId, order.Date, order.Time, "+++++")
	err := tx.QueryRow(query, order.CinemaId, order.SeatId, order.Date, order.Time).Scan(&order.Id, &order.CinemaId, &order.SeatId, &status)
	if err != nil {
		tx.Rollback()
		fmt.Println(err)
		return errors.New(" CinemaId/SeatId/Date/Time not found")
	}
	if status == "booked" {
		tx.Rollback()
		return errors.New(" The selected seat is already booked")
	}
	query = `update "CinemaSeatSchedule" set status = 'booked' where id = $1;`
	_, err = tx.Exec(query, order.Id)
	if err != nil {
		tx.Rollback()
		return errors.New(" Internal Server Error")
	}
	query = `insert into "Order" ("order_code", "cinema_seat_schedule_id", "user_id") values ('ORD-' || nextval('"Order_id_seq"')-1, $1, $2) returning "order_code"`
	err = tx.QueryRow(query, order.Id, userId).Scan(&order.OrderCode)
	if err != nil {
		tx.Rollback()
		return errors.New(" Internal Server Error")
	}
	return nil
}
