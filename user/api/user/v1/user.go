package v1


func (x *CreateUserRequest) StringWithMask(mask string) string {
	ret := proto.Clone(x).(*CreateUserRequest)
	ret.Password = mask
	ret.ConfirmPassword = mask
	return ret.String()
}

func (x *AdminUpdateUserRequest) StringWithMask(mask string) string {
	ret := proto.Clone(x).(*AdminUpdateUserRequest)
	if ret.User != nil {
		ret.User.Password = mask
		ret.User.ConfirmPassword = mask
	}

	return ret.String()
}
