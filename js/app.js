const AUTH_URL = 'https://api.instagram.com/oauth/authorize?app_id=554472575139442&redirect_uri=https://saich-shopmatic.github.io/insta-feed/&scope=user_profile,user_media&response_type=code';
const APP_ID = '554472575139442'
const APP_SECRET = '70a56acaa155786732231f381d84a2e9' 
const REDIRECT_URI = 'https://saich-shopmatic.github.io/insta-feed/'
let code = ''
let accessToken= ''
let user_id = ''

function authUser() {
    location.href = AUTH_URL
}
