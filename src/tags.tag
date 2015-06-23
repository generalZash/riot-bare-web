/**
 * Mixins
 */
/*var pageMixin = {
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
}*/

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
    <pane-likes></pane-likes>
  </section>
</r-main>

<pane-home>
  <div id='pane-home' class='pane-home pane {hidden: this.isHidden()}'>
    <h1>Hi, I'm Gen</h1>
    <p>I like to do stuff</p>
    <p>{this.screen()}</p>
    <p>{this.viewport()}</p>
  </section>
  console.log(opts);

  screen() {
    return window.screen.width + ', ' + window.screen.height;
  }

  viewport() {
    return document.documentElement.clientWidth + ', ' + document.documentElement.clientHeight;
  }
</pane-home>

<pane-likes>
  <div class='pane-likes pane {hidden: this.isHidden()}'>
  </div>
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
