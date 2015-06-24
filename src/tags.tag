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

<r-bg>
  <star-md class='star1'></star-md>
  <star-md class='star2'></star-md>
  <star-md class='star3'></star-md>
  <star-md class='star4'></star-md>
  <star-md class='star5'></star-md>
  <star-md class='star6'></star-md>
  //screenArea = window.screen.width * window.screen.height;
</r-bg>


<star-sm class='star-sm'>
  this.root.style.left = opts.width;
  this.root.style.top = opts.height;
</star-sm>

<star-md>
  // The root node can't access `opts`, which is really stupid, riot should change it
  // for now, we need to use this.root.className
  this.root.className = 'star-md ' + opts.class;
</star-md>

<r-bg-image class='bg-image'>
</r-bg-image>

// the main container
<r-main>
  <section class='container'>
    <pane-home></pane-home>
    <pane-skills></pane-skills>
    <pane-likes></pane-likes>
  </section>
</r-main>

<pane-home>
  <div id='pane-home' class='pane-home pane {hidden: !this.isActive()}'>
    <div class='content'>
      <h1>Hi, I'm Gen</h1>
      <p>I'm a code guy who fell into a fron-end dev position (and I'm loving it). My day to day work 
        involves lots of Javascript, HTML5, CSS3, and some Java for running Selenium. I love solving 
        problems by thinking out loud (around other people).</p>

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
        example, I built this website from scratch so I know what I'm doing but I rate myself 3.5
        for HTML5/CSS3. I would never be able to claim "100% Mastah!" of any popular modern 
        programming language.</div>
      
      <section class='skill-list'>
        <r-skill each='{skill, i in skills}' name='{skill.name}' level='{skill.level}' skillIcon='{skill.skillIcon}'></r-skill>
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
  console.log(opts);

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
  </div>

  this.mixin(ActivatableMixin);
  this.paneId = 'likes';
  
  this.active = false;
</pane-likes>

<r-tabs>
  <ul class='group'>
    <li each={tab, i in tabs} class='tab-item { is-active: parent.isActiveTab(tab.ref)}' onclick='{ parent.toggleTab }'>
      <span class='drag-handle'>= </span>
      <div class='editable-div' contenteditable='true'>{tab.title}</div>
    </li>
  </ul>
  <br><br><br><br><br><br><br><br>
  <div class='tab-content'>
    <div each={tab, i in tabs} class='tab-content-item { is-active: parent.isActiveTab(tab.ref) }'>{tab.content}</div>
  </div>
  <div>
  <br><br><br><br><br><br><br><br>

  this.mixin(ActivatableMixin);

  this.tabs = [
    { title: 'Tab 1', ref: 'tab1', content: '1 content'},
    { title: 'blah', ref: 'tab2', content: 'some other'},
    { title: 'Tab 3', ref: 'tab3', content: 'and some tagggs'}
  ];

  this.activeTab = 'tab1';

  isActiveTab(tab) {
    return this.activeTab === tab;
  }

  toggleTab(event) {
    this.activeTab = event.item.tab.ref;
    //return true;
  }
</r-tabs>
