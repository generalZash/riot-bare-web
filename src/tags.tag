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
    { title:'about',   class:'about',   id:'about',   linkAddr:'#about'  },
    { title:'skills',  class:'skills',  id:'skills',  linkAddr:'#skills' },
    { title:'likes',   class:'likes',   id:'likes',   linkAddr:'#likes'  },
    { title:'contact', class:'contact', id:'contact', linkAddr:'#contact'}
  ];

  isActive(id) {
    return this.activeLinkId === id;
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
  <div id='pane-home' class='pane-home pane {hidden: !this.isActive()}'>
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

      <p>{this.screen()}</p>
      <p>{this.viewport()}</p>
    </div>
    <div class='side-image'>
      <img src='app/img/gake_new_lg.png'></img>
    </div>
  </section>

  this.mixin(ActivatableMixin);
  this.paneId = 'about';
  
  this.active = true;

  screen() {
    return window.screen.width + ', ' + window.screen.height;
  }

  viewport() {
    return document.documentElement.clientWidth + ', ' + document.documentElement.clientHeight;
  }
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
    <p>some text here</p>
    <div class='grid-container'>
      <r-likey each='{thing, i in likedThings}'
        class       = '{thing.class}' 
        imgsrc      = '{thing.imgsrc}'
        title       = '{thing.title}' 
        description = '{thing.description}'></r-likey>
    </div>
  </div>

  this.mixin(ActivatableMixin);
  this.paneId = 'likes';
  
  this.active = false;

  //todo: 
  // make container
  // make inner pane
  // remove overflow with hidden
  // css boxshadow
  // icon
  // description
  // dragify

  // maybe stagger load, watch something until the pane-likes.active==true
  // then, mount domNodes

  //#####http://www.smashingmagazine.com/2014/09/04/animating-without-jquery/

  this.likedThings = [
    {imgsrc:'app/img/sushi.png', title:'test', description:'test stuff'},
    {imgsrc:'app/img/sushi.png', title:'something', description:'more'},
    {imgsrc:'app/img/sushi.png', title:'more yo', description:'yeah'},
    {imgsrc:'app/img/sushi.png', title:'test', description:'test stuff'},
    {imgsrc:'app/img/sushi.png', title:'something', description:'more'},
    {imgsrc:'app/img/sushi.png', title:'more yo', description:'yeah'},
    {imgsrc:'app/img/sushi.png', title:'test', description:'test stuff'},
    {imgsrc:'app/img/sushi.png', title:'something', description:'more'},
    {imgsrc:'app/img/sushi.png', title:'more yo', description:'yeah'},
    {imgsrc:'', title:'okok', description:'ummmm'}
  ];
</pane-likes>

<r-likey>
  <img src='{opts.imgsrc}'></img>
    
  <div class='floating-text'>
    <span class='description'>{opts.description}</span>
    <span class='title'>{opts.title}</span>
  </div>
  console.log(opts);
</r-likey>

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

  this.mixin(ActivatableMixin);
  this.paneId = 'contact';
  this.active = false;
</pane-contact>

<r-footer class='footer'>
  <span>&copy; Gen Edwards 2015</span>
</r-footer>
