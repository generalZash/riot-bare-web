/**
 * Mixins
 */
var pageMixin = {
  init: function() {
    riot.route(function(page) {
      if (page === this.pageId)
        this.showPage();
      else
        this.hidePage();
    }.bind(this))
  },

  showPage: function() {
    this.hidden = false;
    this.update();
  },

  hidePage: function() {
    this.hidden = true;
    this.update();
  },

  isHidden: function() {
    return this.hidden;
  }
}

riot.tag('r-header', '<div class="{ sticky: this.isSticky()}">header area</div>', function(opts) {

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
riot.tag('r-main', '<page-home></page-home> <page-likes></page-likes>', function(opts) {

});

riot.tag('page-home', '<div class="page-home page {hidden: this.isHidden()}"></div>', function(opts) {
  this.mixin(pageMixin);
  this.pageId = 'home';
  
  this.hidden = false;

});

riot.tag('page-likes', '<div class="page-likes page {hidden: this.isHidden()}"></div>', function(opts) {
  this.mixin(pageMixin);
  this.pageId = 'likes';
  
  this.hidden = true;

});

riot.tag('r-tabs', '<ul class="group"> <li each="{tab, i in tabs}" class="tab-item { is-active: parent.isActiveTab(tab.ref)}" onclick="{ parent.toggleTab }"> <span class="drag-handle">= </span> <div class="editable-div" contenteditable="true">{tab.title}</div> </li> </ul> <br><br><br><br><br><br><br><br> <div class="tab-content"> <div each="{tab, i in tabs}" class="tab-content-item { is-active: parent.isActiveTab(tab.ref) }">{tab.content}</div> </div> <div> <br><br><br><br><br><br><br><br>', function(opts) {

  this.mixin(pageMixin);

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
