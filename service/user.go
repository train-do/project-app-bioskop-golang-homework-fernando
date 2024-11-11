package service

import (
	"database/sql"

	"github.com/google/uuid"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/repository"
)

type UserService struct {
	db   *sql.DB
	repo *repository.UserRepo
}

func NewUserService(db *sql.DB, repo *repository.UserRepo) *UserService {
	return &UserService{db, repo}
}

func (s *UserService) Register(user *model.User) error {
	err := s.repo.Insert(s.db, user)
	if err != nil {
		return err
	}
	return nil
}
func (s *UserService) Login(user *model.User) error {
	user.Token = uuid.New().String()
	err := s.repo.Update(s.db, user, true)
	if err != nil {
		return err
	}
	return nil
}
func (s *UserService) Logout(u string, t string) error {
	err := s.repo.Update(s.db, &model.User{Username: u, Token: t}, false)
	if err != nil {
		return err
	}
	return nil
}
