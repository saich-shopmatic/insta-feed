const AUTH_URL = 'https://api.instagram.com/oauth/authorize?app_id=554472575139442&redirect_uri=https://saich-shopmatic.github.io/insta-feed/&scope=user_profile,user_media&response_type=code';
const APP_ID = '554472575139442'
const APP_SECRET = '70a56acaa155786732231f381d84a2e9' 
const REDIRECT_URI = 'https://saich-shopmatic.github.io/insta-feed/'
const GRANT_TYPE= 'authorization_code'
const ACCESSTOKEN_URL = 'https://api.instagram.com/oauth/access_token'

function authUser() {
    location.href = JSON.stringify(AUTH_URL)
    console.log('Page is redirecting to: ', AUTH_URL)
}

async function fetchAccessToken(code) {
    params = {app_id: APP_ID, app_secret: APP_SECRET, grant_type: GRANT_TYPE, redirect_uri: REDIRECT_URI, code: code }
    if (!!code) {
        const response = await fetch(ACCESSTOKEN_URL, {
            method: 'POST',
            body: JSON.stringify(params) 
            })
            return await response.json();
    }  else {
        console.log('No code arg found in fetchAccessToken')
        return {}
    }
}

function fetchAuthCode() {
    let params = (new URL(document.location)).searchParams
    if (!!params.get('code')) {
        code = params.get('code')
        console.log('Auth code:', code)
        let userInfo = fetchAccessToken(code)
        console.log(userInfo)
    } else {
        code = ''
        console.log('No Code found in request params.', code)
    }
}
