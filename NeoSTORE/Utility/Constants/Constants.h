//
//  Constants.h
//  NeoSTORE
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#pragma mark - User
#define BASE_URL @"http://staging.php-dev.in:8844/trainingapp/api/"
#define REGISTER_URL @"http://staging.php-dev.in:8844/trainingapp/api/users/register"
#define LOGIN_URL @"http://staging.php-dev.in:8844/trainingapp/api/users/login"
#define FORGOT_PASSWORD_URL @"http://staging.php-dev.in:8844/trainingapp/api/users/forgot"
#define CHANGE_PASSWORD_URL @"http://staging.php-dev.in:8844/trainingapp/api/users/change"
#define UPDATE_ACCOUNT_DETAILS_URL @"http://staging.php-dev.in:8844/trainingapp/api/users/update"
#define FETCH_ACCOUNT_DETAILS_URL @"http://staging.php-dev.in:8844/trainingapp/api/users/getUserData"

#pragma mark - Product
#define GET_PRODUCT_LIST @"http://staging.php-dev.in:8844/trainingapp/api/products/getList"
#define GET_PRODUCT_DETAILS_URL @"http://staging.php-dev.in:8844/trainingapp/api/products/getDetail"
#define SET_PRODUCT_RATING_URL @"http://staging.php-dev.in:8844/trainingapp/api/products/setRating"

#pragma mark - Cart
#define ADD_TO_CART @"http://staging.php-dev.in:8844/trainingapp/api/addToCart"
#define EDIT_CART_URL @"http://staging.php-dev.in:8844/trainingapp/api/editCart"
#define DELETE_CART_URL @"http://staging.php-dev.in:8844/trainingapp/api/deleteCart"
#define LIST_CART_ITEMS_URL @"http://staging.php-dev.in:8844/trainingapp/api/cart"

#pragma mark - Order
#define ORDER_URL @"http://staging.php-dev.in:8844/trainingapp/api/order"
#define ORDER_LIST_URL @"http://staging.php-dev.in:8844/trainingapp/api/orderList"
#define ORDER_DETAILS_URL @"http://staging.php-dev.in:8844/trainingapp/api/orderDetail"


//----------------------------------------------------------------------------------------------------------------------------
#define HOME_NAVIGATION @"HomeNavigation"
#define SM_ROOT_VIEW_CONTROLLER @"SMRootViewController"
#define LOGIN_VIEW_CONTROLLER_ID @"LoginViewController"
#define REGISTER_VIEW_CONTROLLER_ID @"RegisterViewController"
#define FORGOT_PASSWORD_VIEW_CONTROLLER_ID @"ForgotPasswordViewController"
#define HOME_VIEW_CONTROLLER_ID @"HomeViewController"
#define PRODUCT_LIST_VIEW_CONTROLLER_ID @"ProductListViewController"
#define PRODUCT_DETAILS_VIEW_CONTROLLER_ID @"ProductDetailsViewController"

#define MY_CART_VIEW_CONTROLLER_ID @"MyCartViewController"
#define MY_ACCOUNT_VIEW_CONTROLLER_ID @"MyAccountViewController"
#define STORE_LOCATOR_VIEW_CONTROLLER_ID @"StoreLocatorViewController"
#define MY_ORDERS_VIEW_CONTROLLER_ID @"MyOrdersViewController"
#define RESET_PASSWORD_VIEW_CONTROLLER_ID @"ResetPasswordViewController"

#define ADD_ADDRESS_VIEW_CONTROLLER_ID @"AddAddressViewController"
#define ORDER_DETAILS_VIEW_CONTROLLER_ID @"OrderDetailsViewController"

#define COLLECTION_VIEW_CELL_ID @"CategoryImagesCollectionViewCell"
#define PRODUCT_LIST_VIEW_CELL_ID @"ProductListTableViewCell"
#define LEFT_MENU_TABLE_VIEW_CELL @"LeftMenuCellTableViewCell"

#define MY_CART_PRODUCT_CELL_ID @"MyCartProductCell"
#define MY_CART_TOTAL_CELL_ID @"MyCartTotalCell"
#define MY_CART_BUTTON_CELL_ID @"MyCartButtonCell"

#define MY_ORDER_TABLE_VIEW_CELL_ID @"MyOrdersTableViewCell"
#define ORDER_DETAILS_TABLE_VIEW_CELL_ID @"OrderDetailsTableViewCell"
#define STORE_LOCATOR_TABLE_VIEW_CELL_ID @"StoreLocatorTableViewCell"


#define KEY_LOGIN_STATUS @"KEY_LOGIN_STATUS"
#define KEY_LOGIN_USERID @"KEY_LOGIN_USERID"
#define KEY_LOGIN_ACCESS_TOKEN @"KEY_LOGIN_ACCESS_TOKEN"
#define KEY_LOGIN_EMAIL @"KEY_LOGIN_EMAIL"
#define KEY_LOGIN_FIRSTNAME @"KEY_LOGIN_FIRSTNAME"
#define KEY_LOGIN_LASTNAME @"KEY_LOGIN_LASTNAME"
#define KEY_LOGIN_MOBILE @"KEY_LOGIN_MOBILE"
#define KEY_LOGIN_BIRTHDATE @"KEY_LOGIN_BIRTHDATE"
#define KEY_PROFILE_PICTURE @"KEY_PROFILE_PICTURE"
#define KEY_USER_IMAGE_DATA @"userImageData"
//----------------------------------------------------------------------------------------------------------------------------
#define GENDER_MALE @"Male"
#define GENDER_FEMALE @"Female"
#define NeoSTORE @"NeoSTORE"

#define USERNAME @"Username"
#define PASSWORD @"Password"
#define CONFIRM_PASSWORD @"Confirm password"
#define FIRST_NAME @"First name"
#define LAST_NAME @"Last name"
#define EMAIL @"Email"
#define PHONE_NUMBER @"Phone number"

#define SOCIAL_POST_MESSAGE @"Find your perfect Furniture for your HOME today... With NeoSTORE , discovering the furniture is fun, simple & right on your iPhone..!!"

#define FACEBOOK_ERROR_MESSAGE @"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup."

#define TWITTER_ERROR_MESSAGE @"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup."


#define NeoSTORE_ADDRESS_DADAR @"4th floor,The Ruby, 29,Dadar (w) Mumbai - 400028"
#define NeoSTORE_ADDRESS_RABALE @"501, Sigma IT Park, Rabale, Navi Mumbai, 400701"
#define NeoSTORE_ADDRESS_PRABHADEVI @"124 Unique Industrial Estate, Off V S Marg, Prabhadevi, Mumbai, 400025"
#define NeoSTORE_ADDRESS_PUNE @"Blue Ridge SEZ, Rajiv Gandhi Infotech Park - Phase-I, Hinjewadi, Pune,  411027"

#define dadar_latitude @"19.0297071"
#define dadar_longitude @"72.8446217"

#define prabhadevi_latitude @"19.0224036"
#define prabhadevi_longitude @"72.829103"

#define rabale_latitude @"19.1413046"
#define rabale_longitude @"72.9388406"

#define pune_latitude @"18.5858002"
#define pune_longitude @"73.7369607"
//----------------------------------------------------------------------------------------------------------------------------
#define TITLE_TABLES @"Tables"
#define TITLE_CHAIRS @"Chairs"
#define TITLE_SOFAS @"Sofa"
#define TITLE_BEDS @"Beds"

#define TABLE @"Table"
#define CHAIR @"Chair"
#define SOFA @"Sofa"
#define BED @"Bed"

#pragma mark -  Navigatin item titles
#define HOME @"Home"
#define MY_CART @"My Cart"
#define MY_ACCOUNT @"My Account"
#define MY_ORDERS @"My Orders"
#define STORE_LOCATOR @"Store Locator"
#define EDIT_PROFILE @"Edit Profile"
#define RESET_PASSWORD @"Reset Password"

#define SUBMIT_BUTTON @"SUBMIT"
#define EDIT_PROFILE_BUTTON @"EDIT PROFILE"

#define ADD_ADDRESS @"Add Address"
//----------------------------------------------------------------------------------------------------------------------------
#pragma mark -  Validation Messages
#define NO_NETWORK @"The Internet connection appears to be offline"
#define ENTER_USERNAME @"Enter username"
#define ENTER_PASSWORD @"Enter password"
#define ENTER_FIRST_NAME @"Enter first name"
#define ENTER_LAST_NAME @"Enter last name"
#define ENTER_EMAIL @"Enter email"
#define ENTER_CONFIRM_PASSWORD @"Confirm password"
#define ENTER_PHONE_NUMBER @"Enter phone number"
#define NEW_PASSWORD_SENT_ON_EMAIL @"New password sent on email"
#define PLEASE_ENTER_A_VALID_EMAIL @"Please enter a valid Email"

#define PLEASE_SIGN_AGREEMENT @"Please sign agreement"
#define PASSWORD_NOT_MATCH @"Confirm password didn't match"

#define ONLY_ALPHABATES_ARE_ALLOWED @"Only alphabates characters are allowed."
#define ENTER_VALID_EMAIL @"Enter valid email."
#define ONLY_10_DIGIT_NUMERIC_VALUE_IS_ALLOWED @"Only 10 digit numeric value is allowed"
#define ENTER_BIRTHDATE @"Enter birthdate"
#define PLEASE_ENTER_CURRENT_PASSWORD @"Please, enter current password"
#define PLEASE_ENTER_NEW_PASSWORD @"Please, enter new password"
#define PLEASE_CHECK_PASSWORD_MISMATCH @"Password mismatched"
#define CURRENT_PASSWORD @"Current Password"
#define NEW_PASSWORD @"New Password"

#define LOGOUT_MESSAGE @"Are you sure you want to log out?"
#define LOGOUT_TITLE  @"NeoSTORE"

#define CART_IS_EMPTY @"Cart is empty"
#define MAX_QUANTITY @"Max Quantity :  0 to 8"

#define USER_MUST_BE_A_VALID_EMAIL @"Username must be a valid email"
#define PLEASE_ENTER_ALL_FIELDS @"Please enter all fields"

#define ENTER_VALID_ZIPCODE @"Only 6 digit numeric value is allowed"

#define ENTER_ADDRESS @"Enter Address"
#define ENTER_LANDMARK @"Enter Landmark"
#define ENTER_CITY @"Enter City"
#define ENTER_ZIPCODE @"Enter Zipcode"
#define ENTER_STATE @"Enter State"
#define ENTER_COUNTRY @"Enter Country"

#define BIRTHDATE_IS_GREATER_THAN_CURRENT_DATE @"Birthdate is greater than current date"
#define INVALID_BIRTHDATE @"Invalid Birthdate"

#define ENTER_QUANTITY @"Enter Quantity"
#define QUANTITY_MUST_BE_1_TO_7 @"Quantity must be 1 to 7"
#define RATE_PRODUCT @"Rate Product"
//------------------------------------------------------------------------------------------------------------------------
#pragma mark - Images Constants
#define IMAGE_USER @"username_icon"
#define IMAGE_PASSWORD @"password_icon"
#define IMAGE_EMAIL @"email_icon"

#define IMAGE_PASSWORD_UNLOCK @"cpassword_icon"
#define IMAGE_PHONE @"cellphone_icon"
#define IMAGE_SELECT @"chky"
#define IMAGE_UNSELECT @"chkn"
#define IMAGE_CHECKED @"checked_icon"
#define IMAGE_UNCHECKED @"uncheck_icon"
#define IMAGE_MENU @"menu_icon"
#define IMAGE_SEARCH @"search.png"
#define IMAGE_BACK @"backimage"
#define IMAGE_BIRTHDATE @"dob_icon"


#define IMAGE_USER_COLOR @"user_color.png"

#define IMAGE_TABLES @"tableicon"
#define IMAGE_SOFAS @"sofaicon"
#define IMAGE_CHAIRS @"chairsicon"
#define IMAGE_BEDS @"beds"

#define IMAGE_SLIDER1 @"slider_img1.jpg"
#define IMAGE_SLIDER2 @"slider_img2.jpg"
#define IMAGE_SLIDER3 @"slider_img3.jpg"
#define IMAGE_SLIDER4 @"slider_img4.jpg"

#define IMAGE_PLACEHOLDER @"placeholder.png"

#define IMAGE_STAR_UNFILLED @"star_unfilled"
#define IMAGE_STAR_FILLED @"star_filled"

#define IMAGE_HOME @"home"
#define IMAGE_SM_MY_CART @"my_cart"
#define IMAGE_SM_TABLES @"table"
#define IMAGE_SM_SOFAS @"sofa"
#define IMAGE_SM_CHAIRS @"chair"
#define IMAGE_SM_BEDS @"sm_beds"
#define IMAGE_SM_MY_ACCOUNT @"username_icon"
#define IMAGE_SM_STORE_LOCATOR @"storelocator_icon"
#define IMAGE_SM_MY_ORDERS @"myorders_icon"
#define IMAGE_SM_LOYOUT @"logout_icon"


#pragma mark - Menu Item Names
#define LEFT_MENU_MY_CART @"My Cart"
#define LEFT_MENU_TABLE @"Tables"
#define LEFT_MENU_SOFAS @"Sofas"
#define LEFT_MENU_CHAIRS @"Chairs"
#define LEFT_MENU_BEDS @"Beds"
#define LEFT_MENU_MY_ACCOUNT @"My Account"
#define LEFT_MENU_STORE_LOCATOR @"Store Locator"
#define LEFT_MENU_MY_ORDERS @"My Orders"
#define LEFT_MENU_LOYOUT @"Logout"


#define BUTTON_GO_TO_SETTING @"Go To Setting"
#define BUTTON_CANCEL @"Cancel"
#define FACEBOOK @"Facebook"
#define TWITTER @"Twitter"
#endif /* Constants_h */
