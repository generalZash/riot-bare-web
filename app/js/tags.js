riot.tag('tabs', '', function(opts) {

});

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

  this.rand = function() {
    return Math.random() * 300 + 100;
  }.bind(this);

  this.startTime = new Date().getTime();

  this.starTimer = function() {
    setTimeout( function () {
      if (new Date().getTime() < this.startTime + 20000) {
        var newStar = document.createElement('star-sm');
        this.root.appendChild(newStar);
        riot.mount(newStar, 'star-sm', {test: "3000"});
        this.starTimer();
      }
    }.bind(this), this.rand());
  }.bind(this);



  this.starTimer();


});


riot.tag('star-sm', '', 'class=\'star-sm\'', function(opts) {
  this.rand = function() {
    return Math.random() * 2000;
  }.bind(this);

  this.root.style.left = '-200';
  this.root.style.top = this.rand();

});

riot.tag('star-md', '', function(opts) {

  this.root.className = 'star-md ' + opts.class;

});

riot.tag('r-bg-image', '', 'class=\'bg-image\'', function(opts) {

});

riot.tag('r-tabs', '<ul class="group"> <li each="{tab, i in tabs}" class="tab-item { is-active: parent.isActiveTab(tab.ref)}" onclick="{ parent.toggleTab }"> <span class="drag-handle">= </span> <div class="editable-div" contenteditable="true">{tab.title}</div> </li> </ul> <br><br><br><br><br><br><br><br> <div class="tab-content"> <div each="{tab, i in tabs}" class="tab-content-item { is-active: parent.isActiveTab(tab.ref) }">{tab.content}</div> </div> <div> <br><br><br><br><br><br><br><br>', function(opts) {

  this.tabs = [
    { title: 'Tab 1', ref: 'tab1', content: '1 content'},
    { title: 'Tab 2', ref: 'tab2', content: 'some other'},
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
