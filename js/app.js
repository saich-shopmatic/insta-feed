// Use the CDN or host the script yourself
// https://cdnjs.cloudflare.com/ajax/libs/instafeed.js/1.4.1/instafeed.min.js
// https://matthewelsom.com/assets/js/libs/instafeed.min.js

var userFeed = new Instafeed({
    get: 'user',
    userId: '8987997106',
    clientId: '924f677fa3854436947ab4372ffa688d',
    accessToken: '8987997106.924f677.8555ecbd52584f41b9b22ec1a16dafb9',
    resolution: 'standard_resolution',
    template: '<a href="{{link}}" target="_blank" id="{{id}}"><img src="{{image}}" /></a>',
    sortBy: 'most-recent',
    limit: 4,
    links: false
  });
  userFeed.run();
  