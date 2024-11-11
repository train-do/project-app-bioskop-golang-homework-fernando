package repository

import (
	"database/sql"
	"errors"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
)

type CinemaRepo struct{}

func NewCinemaRepo() *CinemaRepo {
	return &CinemaRepo{}
}
func (s *CinemaRepo) FindAll(db *sql.DB) ([]model.Cinema, error) {
	var cinemas []model.Cinema
	query := `select id,name,location from "Cinema";`
	rows, err := db.Query(query)
	if err != nil {
		return []model.Cinema{}, errors.New(" Internal Server Error")
	}
	for rows.Next() {
		var cinema model.Cinema
		err := rows.Scan(&cinema.Id, &cinema.Name, &cinema.Location)
		if err != nil {
			return []model.Cinema{}, errors.New(" Internal Server Error")
		}
		cinemas = append(cinemas, cinema)
	}
	return cinemas, nil
}
func (s *CinemaRepo) FindById(db *sql.DB, cinema *model.Cinema) error {
	query := `select * from "Cinema" where id=$1;`
	err := db.QueryRow(query, cinema.Id).Scan(&cinema.Id, &cinema.Name, &cinema.Location, &cinema.Seats)
	if err != nil {
		return errors.New(" Cinema not found")
	}
	return nil
}
func (s *CinemaRepo) FindAllSeatsSchedule(db *sql.DB, id int, date string, time string) ([]model.Seat, error) {
	var seats []model.Seat
	query := `select s2."name" , css.status from "CinemaSeatSchedule" css join "Schedule" s on s.id = css.schedule_id join "CinemaSeat" cs on cs.id = css.cinema_seat_id join "Seat" s2 on s2.id = cs.seat_id where cs.cinema_id = $1 and s.date = $2 and s.time = $3 order by css.id;`
	rows, err := db.Query(query, id, date, time)
	if err != nil {
		return []model.Seat{}, errors.New(" No available seats found for the specified cinema and schedule")
	}
	for rows.Next() {
		var seat model.Seat
		rows.Scan(&seat.SeatId, &seat.Status)
		if err != nil {
			return []model.Seat{}, errors.New(" No available seats found for the specified cinema and schedule")
		}
		seats = append(seats, seat)
	}
	return seats, nil
}
