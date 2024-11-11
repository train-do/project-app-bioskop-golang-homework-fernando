package repository

import (
	"database/sql"
	"errors"
	"strings"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
)

type UserRepo struct{}

func NewUserRepo() *UserRepo {
	return &UserRepo{}
}

func (s *UserRepo) FindByToken(db *sql.DB, user *model.User) error {
	query := `select email from "User" where username ilike $1 and token=$2;`
	err := db.QueryRow(query, user.Username, user.Token).Scan(&user.Email)
	if err != nil {
		return errors.New(" No Authentication")
	}
	return nil
}
func (s *UserRepo) Insert(db *sql.DB, user *model.User) error {
	query := `insert into "User" ("username", "password", "email") values ($1, $2, $3);`
	_, err := db.Exec(query, user.Username, user.Password, user.Email)
	if err != nil {
		if strings.Contains(err.Error(), "username") {
			return errors.New(" Username already exists")
		} else if strings.Contains(err.Error(), "email") {
			return errors.New(" Email already exists")
		}
	}
	return nil
}
func (s *UserRepo) Update(db *sql.DB, user *model.User, doLogin bool) error {
	if doLogin {
		query := `update "User" set token=$1 where username ilike $2 and password=$3 returning id, email;`
		err := db.QueryRow(query, user.Token, user.Username, user.Password).Scan(&user.Id, &user.Email)
		user.Password = ""
		if err != nil {
			return errors.New(" Invalid username or password")
		}
	} else {
		query := `update "User" set token=$1 where username ilike $2 and token=$3 returning email;`
		err := db.QueryRow(query, "", user.Username, user.Token).Scan(&user.Email)
		if err != nil {
			// fmt.Println(err, ">>>>>>")
			return errors.New(" Something Wrong With Cookie, You Manipulated It")
		}
	}
	return nil
}
