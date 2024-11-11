package model

type Order struct {
	Id            int    `json:"id,omitempty"`
	OrderCode     string `json:"bookingId"`
	CinemaId      int    `json:"cinemaId"`
	SeatId        string `json:"seatId"`
	Date          string `json:"date"`
	Time          string `json:"time"`
	PaymentMethod string `json:"paymentMethod"`
}
