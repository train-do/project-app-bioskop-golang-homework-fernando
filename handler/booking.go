package handler

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/service"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/utils"
)

type OrderHandler struct {
	service *service.OrderService
}

func NewOrderHandler(service *service.OrderService) *OrderHandler {
	return &OrderHandler{service}
}

func (h *OrderHandler) CreateOrder(w http.ResponseWriter, r *http.Request) {
	var order model.Order
	id, _ := r.Cookie("id")
	if err := json.NewDecoder(r.Body).Decode(&order); err != nil {
		fmt.Println(err)
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, "Invalid Body JSON")
		json.NewEncoder(w).Encode(response)
		return
	}
	err := h.service.CreateOrder(&order, utils.ToInt(id.Value))
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, model.Response{Data: order}, http.StatusOK, "")
	json.NewEncoder(w).Encode(response)
}
