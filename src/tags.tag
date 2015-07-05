// simple router function to handle hash URL changes
function Router () {
  //TODO: Enhancement: maybe use html history API, maybe overkill
  this.registry = {};

  this.init = function () {
    window.addEventListener('hashchange', this.onChange);
    // return `this` to allow chaining .init
    return this;
  };

  /**
   * Register `ActivatableMixin`s to be notified when there's a change to URL hash
   * @param {String}   path       - the hash path to register with. #/<path>
   * @param {Object}   context    - activation/deactivation's execution context used to fire the 
   *                     `activate()` and `deactivate()` functions
   * @param {Function} activate   - function to call the for pane that matches the hash URL
   * @param {Function} deactivate - function to call for panes that do not match the hash URL
   */
  this.register = function (path, context, activate, deactivate) {
    this.registry[path] = {
      contex    : context,
      activate  : activate,
      deactivate: deactivate
    }
  };

  this.onChange = function (event) {
    //TODO: 404
    var newPath = event.newURL.split('#/');
    newPath = (newPath.length === 2) ? newPath[1] : undef;
    if (this.registry[newPath]) {
      for (var path in this.registry) {
        var pathObj = this.registry[path];
        if (path == newPath)
          pathObj.activate.call(pathObj.context);
        else
          pathObj.deactivate.call(pathObj.context);
      }
    }
  }.bind(this);
}

var router = new Router().init();

/**
 * Mixins
 */
var ActivatableMixin = {
  init: function() {
    router.register(this.paneLink, this, this.activate, this.deactivate);
    // for initial activation/deactivation
    var path = window.location.href.split('#/');
    if (path.length && path.length > 1) {
      if (path[1] === this.paneLink)
        this.activate();
      else
        this.deactivate();
    }
  },

  activate: function() {
    if (!this.active) {
      this.active = true;
      this.update();
    }
  },

  deactivate: function() {
    if (this.active) {
      this.active = false;
      this.update();
    }
  },

  isActive: function() {
    return this.active;
  }
}

<r-header class='r-header'>
  <div class='container'>
    <div class='header { sticky: this.isSticky()}'>
      <div class='whatsMahName'>Gen Edwards</div>
      <ul class='header-right'>
        <li each={link, i in links} class='section-link { active: parent.isActive(link.id)}'>
          <a href='{link.linkAddr}'>{link.title}</a>
        </li>
      </ul>
    </div>
  </div>

  this.links = [
    { title:'about',   class:'about',   linkAddr:'#/about'  },
    { title:'skills',  class:'skills',  linkAddr:'#/skills' },
    { title:'likes',   class:'likes',   linkAddr:'#/likes'  },
    { title:'contact', class:'contact', linkAddr:'#/contact'}
  ];

  isActive(link) {
    return this.activeLinklink === link;
  }

  this.sticky = false;

  window.addEventListener('scroll', function(event) {
    this.toggleSticky(event);
  }.bind(this));

  toggleSticky(event) {
    this.sticky = (this.root.getBoundingClientRect().top < 10);
    this.update();
  }

  isSticky() {
    return this.sticky
  }
</r-header>

<r-bg-image class='bg-image'>
</r-bg-image>

// the main container
<r-main>
  <section class='container'>
    <pane-home></pane-home>
    <pane-skills></pane-skills>
    <pane-likes></pane-likes>
    <pane-contact>
  </section>
</r-main>

<pane-home>
  <div class='pane-home pane {hidden: !this.isActive()}'>
    <div class='content'>
      <h1>Hi, I'm Gen</h1>
      <p>I'm a coder at heart who thrives in terminal windows that fell into a fron-end dev 
        position (and I'm loving it). My day to day work involves lots of Javascript, HTML5, CSS3, 
        and some Java for running Selenium. I love solving problems by thinking out loud (around 
        other people).</p>

      <p>I'm a perpetual hobby collecter, that is, I collect new hobbies. My current obsessions include:</p>
      <ul>
        <li>Aeropress - the best damn coffee</li>
        <li>Javascript MVC - currently Riot.js; I feel this will be replaced with React.js soon...</li>
        <li>Rubik's cube - 3x3 Best avg of 5: 24.32s</li>
      </ul>
    </div>
    <div class='side-image'>
      <img src='app/img/gake_new_lg.png'></img>
    </div>
  </section>

  this.paneLink = 'about';
  this.active = true;
  this.mixin(ActivatableMixin);
</pane-home>

<pane-skills>
  <div class='pane-skills pane {hidden: !this.isActive()}'>
    <div class='content'>
      <h2>Things I can do (that matter for work)</h1>

      <p>Assessment standards:</p>
      <ul>
        <li><icon class='icon-emo-displeased'></icon><span>: Meh - I know what it is</span></li>
        <li><icon class='icon-emo-happy'></icon><span>: I'm alright - I've used this</span></li>
        <li><icon class='icon-emo-grin'></icon><span>: I know my way around it</span></li>
        <li><icon class='icon-emo-thumbsup'></icon><span>: Other people ask me questions about it</span></li>
        <li><icon class='icon-emo-sunglasses'></icon><span>: Master (please slap me if I ever claim to have "Mastered" a skill)</span></li>
      </ul>
      <div class='nb'>*NB: It's sad that I have to state this: I'm honest about my skills. For 
        example, I built this responsive website from scratch so I seem to know what I'm doing but 
        I rate myself 3/5 for HTML5/CSS3. I would never be able to claim "100% Mastah!" of any 
        reasonable programming language.</div>
      
      <section class='skill-list'>
        <r-skill each='{skill, i in skills}' 
          name     ='{skill.name}' 
          level    ='{skill.level}' 
          skillIcon='{skill.skillIcon}'></r-skill>
      </section>
    </div>
  </div>

  this.paneLink = 'skills';
  this.active = false;
  this.mixin(ActivatableMixin);

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
</pane-skills>

<r-skill class='skill-container'>
  <div class='skill-name'>
    <icon class='{opts.skillicon}'> </icon>
    {opts.name}
  </div>
  <div class='skill-level'>
    <icon each='{icon, i in fullIcons}' class='{parent.getIcon(parent.opts.level-1)}'></icon>
    <icon each='{icon, i in emptyIcons}' class='icon-dot'></icon>
  </div>
  // split this array of length 5 between fullIcons and emptryIcons
  var arr = [0,0,0,0,0];
  this.fullIcons=arr.splice(0, opts.level);
  this.emptyIcons=arr;

  this.iconLevel = ['icon-emo-displeased', 'icon-emo-happy', 'icon-emo-grin', 'icon-emo-thumbsup', 'icon-emo-sunglasses'];

  getIcon(level){
    return this.iconLevel[level];
  }
</r-skill>

<pane-likes>
  <div class='pane-likes pane {hidden: !this.isActive()}'>
    <h2>Things I like in no particular order.</h2>
    <div class='grid-container'>
      <r-thing each='{thing, i in likedThings}'
        class       = '{thing.class}' 
        imgsrc      = '{thing.imgsrc}'
        name        = '{thing.name}' 
        description = '{thing.description}'></r-thing>
    </div>

    <h2>Things I dislike in no particular order.</h2>
    <div class='grid-container'>
      <r-thing each='{thing, i in dislikedThings}'
        class       = '{thing.class}' 
        imgsrc      = '{thing.imgsrc}'
        name        = '{thing.name}' 
        description = '{thing.description}'></r-thing>
    </div>
  </div>

  // mixin and mixed in properties
  this.paneLink = 'likes';
  this.active = false;
  this.mixin(ActivatableMixin);

  //todo: 
  // icon
  // description

  // maybe stagger loading of images, watch something until the pane-likes.active==true
  // then, mount domNodes

  this.likedThings = [
    { name        :'Sushi',
      description :'I was a Sushi Chef for 8 years in Seattle...mmm, delicious',
      imgsrc      :'app/img/sushi.png'},
    { name        :'Japanese Knives',
      description :'High carbon steel is the way of the Samurai!',
      imgsrc:'app/img/knife.png'},
    { name        :'Javascript',
      description :'<monospace>Array(16).join("wat"-1) + " Batman!"</monospace>',
      imgsrc:'app/img/javascript-logo.png'},
    { name        :'Aeropress',
      description :'Best damn drip-style coffee!<br> "So, guys, here\'s an idea. Let\'s make frisbees and coffee dispensers.',
      imgsrc:'app/img/aeropress.png'},
    { name        :'Gelato',
      description :'Don\'t call it icecream! Italians be mad!',
      imgsrc:'app/img/gelato.png'},
    { name        :'Comfy Pajamas',
      description :'Doubles as work outfit (on days when you telecommute)',
      imgsrc:'app/img/pajama.png'},
    { name        :'Final Fantasy VII',
      description :'Like, seriously, the BEST RPG EVAH! (subject to subjective opinion)',
      imgsrc      :'app/img/ff7.png'},
    { name        :'My Dog',
      description :'My embarrassingly cute dog: part-time floor cleaner',
      imgsrc:'app/img/empty.png'},
    { name        :'Linux',
      description :'sudo !!',
      imgsrc:'app/img/linux.png'},
    { name        :'Mechanical Keyboards',
      description :'Vortex Poker II, 61 key Hardware programmable keyboard with blank keycaps (Cherry Brown)',
      imgsrc:'app/img/keyboard.png'},
    { name        :'Rubik\'s Cube',
      description :'best Avg of 5: 24.32s (Moyu Weilong v2)',
      imgsrc:'app/img/rubiks-cube.png'},
    { name        :'Flexbox',
      description :'What a life saver',
      imgsrc:'app/img/empty.png'},
    { name        :'Chrome Devtools',
      description :'As legend has it, the original source code was passed down from Merlin [citation needed]. Can\'t imagine writing Javascript without it',
      imgsrc:'app/img/chrome.png'},
    { name        :'Portal',
      description :'The cake is a lie!',
      imgsrc:'app/img/empty.png'},
    { name        :'Minecraft',
      description :'A video game that I can actually play with my kids',
      imgsrc:'app/img/empty.png'},
    { name        :'Small Homes',
      description :'',
      imgsrc:'app/img/empty.png'},
    { name        :'Brazilian Jiu Jitsu',
      description :'The art of joint locks and gently choking people. And NO, Keanu Reeves, you don\'t know Jiu Jitsu',
      imgsrc:'app/img/empty.png'},
    { name        :'Git',
      description :'Provides sanity. Pretty damn good for a "stupid content tracker" -man page',
      imgsrc:'app/img/git.png'},
    { name        :'Tactics Ogre Battle',
      description :'I still can\'t believe that was originally on SNES... insanely ahead of its time',
      imgsrc:'app/img/empty.png'}
  ];

  this.dislikedThings = [
    { name        :'Mixed Tabs',
      description :'<monospace>»»»••••»»••••••••¶</monospace>',
      imgsrc:'app/img/empty.png'}/*,
    { name        :'',
      description :'',
      imgsrc:'app/img/empty.png'},*/
  ];
</pane-likes>

<r-thing>
  <div class='img-container'>
    <img src='{opts.imgsrc}'></img>
  </div>
  <div class='floating-text'>
    <h3 class='name'>{opts.name}</h3>
    <hr></hr>
    <span class='description'><r-raw content='{opts.description}'></r-raw></span>
  </div>
</r-thing>

<r-raw>
  this.root.innerHTML = opts.content
</r-raw>

<pane-contact>
  <div class='pane-contact pane {hidden: !this.isActive()}'>
    <div class='content'>
      <h1>Wanna connect?</h1>
      <p>
        Shoot me an email: thedude(at)generalzash(dot)com </br></br>
        Connect via <a href='https://www.linkedin.com/in/genedwards'>LinkedIn</a>
      </p>
    </div>
    <div class='side-image'>
      <img class='self' src='app/img/all_your_low_polys_are_belong_to_mine.png'></img>
    </div>
  </div>

  this.paneLink = 'contact';
  this.active = false;
  this.mixin(ActivatableMixin);
</pane-contact>

<r-footer class='footer'>
  <span>&copy; Gen Edwards 2015</span>
</r-footer>
