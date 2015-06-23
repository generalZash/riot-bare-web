/**
 * Mixins
 */
var paneMixin = {
  init: function() {
    riot.route(function(pane) {
      if (pane === this.paneId)
        this.showPane();
      else
        this.hidePane();
    }.bind(this))
  },

  showPane: function() {
    this.hidden = false;
    this.update();
  },

  hidePane: function() {
    this.hidden = true;
    this.update();
  },

  isHidden: function() {
    return this.hidden;
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

riot.tag('r-bg', '<star-md class="star1"></star-md> <star-md class="star2"></star-md> <star-md class="star3"></star-md> <star-md class="star4"></star-md> <star-md class="star5"></star-md> <star-md class="star6"></star-md>', function(opts) {

});


riot.tag('star-sm', '', 'class=\'star-sm\'', function(opts) {
  this.root.style.left = opts.width;
  this.root.style.top = opts.height;

});

riot.tag('star-md', '', function(opts) {

  this.root.className = 'star-md ' + opts.class;

});

riot.tag('r-bg-image', '', 'class=\'bg-image\'', function(opts) {

});

// the main container
riot.tag('r-main', '<section class="container"> <pane-home></pane-home> <pane-likes></pane-likes> </section>', function(opts) {

});

riot.tag('pane-home', '<div id="pane-home" class="pane-home pane {hidden: this.isHidden()}"> <div class="content"> <h1>Hi, I\'m Gen</h1> <p>I\'m a code guy who fell into a fron-end dev position (and I\'m loving it). My day to day work involves lots of Javascript, HTML5, CSS3, and some Java for running Selenium. I love solving problems by thinking out loud (around other people).</p> <p>I\'m a perpetual hobby collecter, that is, I collect new hobbies. My current obsessions include:</p> <ul> <li>Aeropress - the best damn coffee</li> <li>Javascript MVC - currently Riot.js; I feel this will be replaced with React.js soon...</li> <li>Rubik\'s cube - 3x3 Best avg of 5: 24.32s</li> </ul> <p>{this.screen()}</p> <p>{this.viewport()}</p> </div> <div class="side-image"> <img src="app/img/gake_new_lg.png"></img> </div> </section>', function(opts) {

  this.mixin(paneMixin);
  this.paneId = 'about';
  
  this.hidden = false;

  this.screen = function() {
    return window.screen.width + ', ' + window.screen.height;
  }.bind(this);

  this.viewport = function() {
    return document.documentElement.clientWidth + ', ' + document.documentElement.clientHeight;
  }.bind(this);

});

riot.tag('pane-likes', '<div class="pane-likes pane {hidden: this.isHidden()}"> </div>', function(opts) {

  this.mixin(paneMixin);
  this.paneId = 'likes';
  
  this.hidden = true;

});

riot.tag('r-tabs', '<ul class="group"> <li each="{tab, i in tabs}" class="tab-item { is-active: parent.isActiveTab(tab.ref)}" onclick="{ parent.toggleTab }"> <span class="drag-handle">= </span> <div class="editable-div" contenteditable="true">{tab.title}</div> </li> </ul> <br><br><br><br><br><br><br><br> <div class="tab-content"> <div each="{tab, i in tabs}" class="tab-content-item { is-active: parent.isActiveTab(tab.ref) }">{tab.content}</div> </div> <div> <br><br><br><br><br><br><br><br>', function(opts) {

  this.mixin(paneMixin);

  this.tabs = [
    { title: 'Tab 1', ref: 'tab1', content: '1 content'},
    { title: 'blah', ref: 'tab2', content: 'some other'},
    { title: 'Tab 3', ref: 'tab3', content: 'and some tagggs'}
  ];

  this.activeTab = 'tab1';

  this.isActiveTab = function(tab) {
    return this.activeTab === tab;
  }.bind(this);

  this.toggleTab = function(event) {
    this.activeTab = event.item.tab.ref;

  }.bind(this);

});
