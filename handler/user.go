package handler

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/service"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/utils"
)

type UserHandler struct {
	service *service.UserService
}

func NewUserHandler(service *service.UserService) *UserHandler {
	return &UserHandler{service}
}

func (h *UserHandler) Register(w http.ResponseWriter, r *http.Request) {
	var user model.User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, "Invalid Body JSON")
		json.NewEncoder(w).Encode(response)
		return
	}
	err := h.service.Register(&user)
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, model.Response{}, http.StatusCreated, "User registered successfully.")
	json.NewEncoder(w).Encode(response)
}
func (h *UserHandler) Login(w http.ResponseWriter, r *http.Request) {
	var user model.User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, "Invalid Body JSON")
		json.NewEncoder(w).Encode(response)
		return
	}
	err := h.service.Login(&user)
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	utils.SetCookie(w, "id", strconv.Itoa(user.Id))
	utils.SetCookie(w, "username", user.Username)
	utils.SetCookie(w, "token", user.Token)
	response := utils.SetResponse(w, model.Response{Data: user}, http.StatusOK, "")
	json.NewEncoder(w).Encode(response)
}
func (h *UserHandler) Logout(w http.ResponseWriter, r *http.Request) {
	username, _ := r.Cookie("username")
	token, _ := r.Cookie("token")
	if err := h.service.Logout(username.Value, token.Value); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	utils.SetCookie(w, "id", "")
	utils.SetCookie(w, "username", "")
	utils.SetCookie(w, "token", "")
	response := utils.SetResponse(w, model.Response{}, http.StatusOK, "User logged out successfully.")
	json.NewEncoder(w).Encode(response)
}
