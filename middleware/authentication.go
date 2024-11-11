package middleware

import (
	"database/sql"
	"net/http"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/repository"
)

func Authentication(db *sql.DB) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			username, err := r.Cookie("username")
			if err != nil || err == http.ErrNoCookie {
				http.Redirect(w, r, "/login", http.StatusUnauthorized)
				return
			}
			token, err := r.Cookie("token")
			if err != nil || err == http.ErrNoCookie {
				http.Redirect(w, r, "/login", http.StatusUnauthorized)
				return
			}
			if err := repository.NewUserRepo().FindByToken(db, &model.User{Username: username.Value, Token: token.Value}); err != nil {
				// fmt.Println(err, "++++")
				http.Redirect(w, r, "/login", http.StatusUnauthorized)
				return
			}
			next.ServeHTTP(w, r)
		})
	}
}
