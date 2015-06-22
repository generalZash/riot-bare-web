/**
 * Mixins
 */
var pageMixin = {
  init: function() {
    riot.route(function(page) {
      if (page === this.pageId)
        this.showPage();
      else
        //this.hidePage();
        ;
    }.bind(this))
  },

  showPage: function() {
    this.root.className = 'test';
  }
}


<r-header>
  <div class='{ sticky: this.isSticky()}'>header area</div>

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

<page-home>

</page-home>

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

  this.mixin(pageMixin);

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
