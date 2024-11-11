package utils

import (
	"net/http"
	"strconv"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
)

func SetResponse(w http.ResponseWriter, data model.Response, statusCode int, message string) model.Response {
	w.WriteHeader(statusCode)
	data.StatusCode = statusCode
	data.Message = message
	return data
}
func SetCookie(w http.ResponseWriter, name string, value string) {
	cookie := http.Cookie{
		Name:   name,
		Value:  value,
		Path:   "/",
		Domain: "localhost",
	}
	http.SetCookie(w, &cookie)
}
func ToInt(str string) int {
	num, err := strconv.Atoi(str)
	if err != nil {
		return 0
	}
	return num
}
