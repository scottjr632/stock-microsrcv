package models

import (
	"fmt"
	"stock-microsrvc/utils"
)

type User struct {
	UUID  string `json:"uuid"`
	Fname string `json:"fname"`
	Lname string `json:"lname"`
	Email string `json:"email"`
}

// setEmail sets the email for the User
func (u *User) setEmail(email string) {
	u.Email = email
}

// setId sets the ID for the User.
func (u *User) setId(id string) {
	u.UUID = id
}

// setName sets the name for the user
func (u *User) setName(fname string, lname string) {
	u.Fname = fname
	u.Lname = lname
}

// SetUserInfo set all neccessary fields of the user struct.
// The only information needed in the user struct is the Email.
func (u *User) SetUserInfo() {
	query := fmt.Sprintf("select id, fname, lname from users.users where email like '%s'", u.Email)

	// TODO : add chechErr function
	res, err := executeQuery(dbpool, query)
	utils.CheckErr(err)

	for res.Next() {
		var id, fname, lname string
		if err := res.Scan(&id, &fname, &lname); err != nil {
			panic(err)
		}

		u.setId(id)
		u.setName(fname, lname)
	}
}
