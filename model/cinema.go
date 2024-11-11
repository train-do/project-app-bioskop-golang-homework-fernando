package model

type Cinema struct {
	Id       int    `json:"id"`
	Name     string `json:"name"`
	Location string `json:"location"`
	Seats    int    `json:"seats,omitempty"`
}

type Seat struct {
	SeatId string `json:"seatId"`
	Status string `json:"status"`
}
