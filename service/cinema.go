package service

import (
	"database/sql"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/repository"
)

type CinemaService struct {
	db   *sql.DB
	repo *repository.CinemaRepo
}

func NewCinemaService(db *sql.DB, repo *repository.CinemaRepo) *CinemaService {
	return &CinemaService{db, repo}
}

func (s *CinemaService) GetAll() ([]model.Cinema, error) {
	cinemas, err := s.repo.FindAll(s.db)
	if err != nil {
		return []model.Cinema{}, err
	}
	return cinemas, nil
}
func (s *CinemaService) GetById(cinema *model.Cinema) error {
	err := s.repo.FindById(s.db, cinema)
	if err != nil {
		return err
	}
	return nil
}
func (s *CinemaService) GetAllSeatsSchedule(id int, date string, time string) ([]model.Seat, error) {
	cinemas, err := s.repo.FindAllSeatsSchedule(s.db, id, date, time)
	if err != nil {
		return []model.Seat{}, err
	}
	return cinemas, nil
}
