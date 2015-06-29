/**
 * Mixins
 */
var ActivatableMixin = {
  init: function() {
    riot.route(function(pane) {
      if (pane === this.paneId)
        this.activate();
      else
        this.deactivate();
    }.bind(this))
  },

  activate: function() {
    this.active = true;
    this.update();
  },

  deactivate: function() {
    this.active = false;
    this.update();
  },

  isActive: function() {
    return this.active;
  }
}

riot.tag('r-header', '<div class="container"> <div class="header { sticky: this.isSticky()}"> <div class="whatsMahName">Gen Edwards</div> <ul class="header-right"> <li each="{link, i in links}" class="section-link { active: parent.isActive(link.id)}"> <a href="{link.linkAddr}">{link.title}</a> </li> </ul> </div> </div>', 'class=\'r-header\'', function(opts) {

  this.links = [
    { title:'about',   class:'about',   id:'about',   linkAddr:'#about'  },
    { title:'skills',  class:'skills',  id:'skills',  linkAddr:'#skills' },
    { title:'likes',   class:'likes',   id:'likes',   linkAddr:'#likes'  },
    { title:'contact', class:'contact', id:'contact', linkAddr:'#contact'}
  ];

  this.isActive = function(id) {
    return this.activeLinkId === id;
  }.bind(this);

  this.sticky = false;

  window.addEventListener('scroll', function(event) {
    this.toggleSticky(event);
  }.bind(this));

  this.toggleSticky = function(event) {
    this.sticky = (this.root.getBoundingClientRect().top < 10);
    this.update();
  }.bind(this);

  this.isSticky = function() {
    return this.sticky
  }.bind(this);

});

riot.tag('r-bg-image', '', 'class=\'bg-image\'', function(opts) {

});

// the main container
riot.tag('r-main', '<section class="container"> <pane-home></pane-home> <pane-skills></pane-skills> <pane-likes></pane-likes> <pane-contact> </section>', function(opts) {

});

riot.tag('pane-home', '<div id="pane-home" class="pane-home pane {hidden: !this.isActive()}"> <div class="content"> <h1>Hi, I\'m Gen</h1> <p>I\'m a coder at heart who thrives in terminal windows that fell into a fron-end dev position (and I\'m loving it). My day to day work involves lots of Javascript, HTML5, CSS3, and some Java for running Selenium. I love solving problems by thinking out loud (around other people).</p> <p>I\'m a perpetual hobby collecter, that is, I collect new hobbies. My current obsessions include:</p> <ul> <li>Aeropress - the best damn coffee</li> <li>Javascript MVC - currently Riot.js; I feel this will be replaced with React.js soon...</li> <li>Rubik\'s cube - 3x3 Best avg of 5: 24.32s</li> </ul> <p>{this.screen()}</p> <p>{this.viewport()}</p> </div> <div class="side-image"> <img src="app/img/gake_new_lg.png"></img> </div> </section>', function(opts) {

  this.mixin(ActivatableMixin);
  this.paneId = 'about';
  
  this.active = true;

  this.screen = function() {
    return window.screen.width + ', ' + window.screen.height;
  }.bind(this);

  this.viewport = function() {
    return document.documentElement.clientWidth + ', ' + document.documentElement.clientHeight;
  }.bind(this);

});

riot.tag('pane-skills', '<div class="pane-skills pane {hidden: !this.isActive()}"> <div class="content"> <h2>Things I can do (that matter for work)</h1> <p>Assessment standards:</p> <ul> <li><icon class="icon-emo-displeased"></icon><span>: Meh - I know what it is</span></li> <li><icon class="icon-emo-happy"></icon><span>: I\'m alright - I\'ve used this</span></li> <li><icon class="icon-emo-grin"></icon><span>: I know my way around it</span></li> <li><icon class="icon-emo-thumbsup"></icon><span>: Other people ask me questions about it</span></li> <li><icon class="icon-emo-sunglasses"></icon><span>: Master (please slap me if I ever claim to have "Mastered" a skill)</span></li> </ul> <div class="nb">*NB: It\'s sad that I have to state this: I\'m honest about my skills. For example, I built this responsive website from scratch so I seem to know what I\'m doing but I rate myself 3/5 for HTML5/CSS3. I would never be able to claim "100% Mastah!" of any reasonable programming language.</div> <section class="skill-list"> <r-skill each="{skill, i in skills}" name =\'{skill.name}\' level =\'{skill.level}\' skillicon="{skill.skillIcon}"></r-skill> </section> </div> </div>', function(opts) {

  this.mixin(ActivatableMixin);
  this.paneId = 'skills';
  this.active = false;

  this.skills = [
    { name:'Javascript',              level:4, skillIcon:''},
    { name:'Java',                    level:3, skillIcon:'icon-coffee-1'},
    { name:'HTML5/CSS3 (Less, Sass)', level:3, skillIcon:'icon-html5'},
    { name:'Selenium',                level:3, skillIcon:''},
    { name:'Jenkins',                 level:2, skillIcon:''},
    { name:'Python',                  level:3, skillIcon:''},
    { name:'Linux',                   level:4, skillIcon:'icon-linux'},
    { name:'git',                     level:3, skillIcon:'icon-git-squared'},
    { name:'Databases',               level:1, skillIcon:''}
  ];

});

riot.tag('r-skill', '<div class="skill-name"> <icon class="{opts.skillicon}"> </icon> {opts.name} </div> <div class="skill-level"> <icon each="{icon, i in fullIcons}" class="{parent.getIcon(parent.opts.level-1)}"></icon> <icon each="{icon, i in emptyIcons}" class="icon-dot"></icon> </div>', 'class=\'skill-container\'', function(opts) {
  var arr = [0,0,0,0,0];
  this.fullIcons=arr.splice(0, opts.level);
  this.emptyIcons=arr;

  this.iconLevel = ['icon-emo-displeased', 'icon-emo-happy', 'icon-emo-grin', 'icon-emo-thumbsup', 'icon-emo-sunglasses'];

  this.getIcon = function(level) {
    return this.iconLevel[level];
  }.bind(this);

});

riot.tag('pane-likes', '<div class="pane-likes pane {hidden: !this.isActive()}"> <h2>Things I like in no particular order.</h2> <div class="grid-container"> <r-thing each="{thing, i in likedThings}" class = \'{thing.class}\' imgsrc = \'{thing.imgsrc}\' name = \'{thing.name}\' description = \'{thing.description}\'></r-thing> </div> <h2>Things I dislike in no particular order.</h2> <div class="grid-container"> <r-thing each="{thing, i in dislikedThings}" class = \'{thing.class}\' imgsrc = \'{thing.imgsrc}\' name = \'{thing.name}\' description = \'{thing.description}\'></r-thing> </div> </div>', function(opts) {
  this.mixin(ActivatableMixin);
  this.paneId = 'likes';
  this.active = false;






  this.likedThings = [
    { name        :'Sushi',
      description :'I was a Sushi Chef for 8 years in Seattle...mmm, delicious',
      imgsrc      :'app/img/sushi.png'},
    { name        :'Japanese Knives',
      description :'High carbon steel is the way of the Samurai!',
      imgsrc:'app/img/knife.png'},
    { name        :'Javascript',
      description :'Array(16).join("wat" - 1) + " Batman!"',
      imgsrc:'app/img/.png'},
    { name        :'Aeropress',
      description :'Best damn drip-style coffee!<br> "So, guys, here\'s an idea. Let\'s make frisbees and coffee dispensers.',
      imgsrc:'app/img/.png'},
    { name        :'Gelato',
      description :'Don\'t call it icecream! Italians be mad!',
      imgsrc:'app/img/.png'},
    { name        :'Comfy Pajamas',
      description :'Doubles as work outfit (on days when you telecommute)',
      imgsrc:'app/img/.png'},
    { name        :'Final Fantasy VII',
      description :'Like, seriously, the BEST RPG EVAH! (subject to subjective opinion)',
      imgsrc      :'app/img/ff7.png'},
    { name        :'My Dog',
      description :'My embarrassingly cute (and often unfriendly) dog: part-time floor cleaner',
      imgsrc:'app/img/.png'},
    { name        :'Linux',
      description :'sudo !!',
      imgsrc:'app/img/.png'},
    { name        :'Mechanical Keyboards',
      description :'Hardware programmable Vortex 61 key keyboard with blank keycaps (Cherry Brown)',
      imgsrc:'app/img/.png'},
    { name        :'Rubik\'s Cube',
      description :'best Avg of 5: 24.32s (Moyu Weilong v2)',
      imgsrc:'app/img/.png'},
    { name        :'Flexbox',
      description :'What a life saver',
      imgsrc:'app/img/.png'},
    { name        :'Chrome Devtools',
      description :'As legend has it, the original source code was passed down from Merlin [citation needed]. Can\'t imagine writing Javascript without it',
      imgsrc:'app/img/.png'},
    { name        :'Portal',
      description :'The cake is a lie!',
      imgsrc:'app/img/.png'},
    { name        :'Minecraft',
      description :'A video game that I can actually play with my kids',
      imgsrc:'app/img/.png'},
    { name        :'Small Homes',
      description :'',
      imgsrc:'app/img/.png'},
    { name        :'Brazilian Jiu Jitsu',
      description :'The art of joint locks and gently choking people. And NO, Keanu Reeves, you don\'t know Jiu Jitsu',
      imgsrc:'app/img/.png'},
    { name        :'Git',
      description :'Provides sanity. Pretty damn good for a "stupid content tracker" -man page',
      imgsrc:'app/img/.png'},
    { name        :'Tactics Ogre Battle',
      description :'I still can\'t believe that was originally on SNES... insanely ahead of its time',
      imgsrc:'app/img/.png'}
  ];

  this.dislikedThings = [
    { name        :'Mixed Tabs',
      description :'<monospace>》》》••》》•••¶</monospace>',
      imgsrc:'app/img/.png'},
    { name        :'',
      description :'',
      imgsrc:'app/img/.png'},
    { name        :'',
      description :'',
      imgsrc:'app/img/.png'},
    { name        :'',
      description :'',
      imgsrc:'app/img/.png'},
    { name        :'',
      description :'',
      imgsrc:'app/img/.png'},
    { name        :'',
      description :'',
      imgsrc:'app/img/.png'},
    { name        :'',
      description :'',
      imgsrc:'app/img/.png'},
  ];

});

riot.tag('r-thing', '<img riot-src="{opts.imgsrc}"></img> <div class="floating-text"> <h3 class="name">{opts.name}</h3> <hr></hr> <span class="description"><r-raw content="{opts.description}"></r-raw></span> </div>', function(opts) {

});

riot.tag('r-raw', '', function(opts) {
  this.root.innerHTML = opts.content

});

riot.tag('pane-contact', '<div class="pane-contact pane {hidden: !this.isActive()}"> <div class="content"> <h1>Wanna connect?</h1> <p> Shoot me an email: thedude(at)generalzash(dot)com </br></br> Connect via <a href="https://www.linkedin.com/in/genedwards">LinkedIn</a> </p> </div> <div class="side-image"> <img class="self" src="app/img/all_your_low_polys_are_belong_to_mine.png"></img> </div> </div>', function(opts) {

  this.mixin(ActivatableMixin);
  this.paneId = 'contact';
  this.active = false;

});

riot.tag('r-footer', '<span>&copy; Gen Edwards 2015</span>', 'class=\'footer\'', function(opts) {

});
