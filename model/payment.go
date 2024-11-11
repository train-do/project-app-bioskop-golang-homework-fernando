package model

type Payment struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

type Transaction struct {
	BookingId      string
	PaymentMethod  string
	PaymentDetails interface{}
}
