package handler

import (
	"encoding/json"
	"net/http"

	"github.com/train-do/project-app-bioskop-golang-homework-fernando/model"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/service"
	"github.com/train-do/project-app-bioskop-golang-homework-fernando/utils"
)

type PaymentHandler struct {
	service *service.PaymentService
}

func NewPaymentHandler(service *service.PaymentService) *PaymentHandler {
	return &PaymentHandler{service}
}

func (h *PaymentHandler) GetAll(w http.ResponseWriter, r *http.Request) {
	data, err := h.service.GetAll()
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusInternalServerError, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, model.Response{Data: data}, http.StatusOK, "")
	json.NewEncoder(w).Encode(response)
}
func (h *PaymentHandler) Pay(w http.ResponseWriter, r *http.Request) {
	var body model.Transaction
	var data model.Response
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, "Invalid Body JSON")
		json.NewEncoder(w).Encode(response)
		return
	}
	err := h.service.Pay(&data, &body)
	if err != nil {
		response := utils.SetResponse(w, model.Response{}, http.StatusBadRequest, err.Error())
		json.NewEncoder(w).Encode(response)
		return
	}
	response := utils.SetResponse(w, data, http.StatusOK, "Payment successful.")
	json.NewEncoder(w).Encode(response)
}
