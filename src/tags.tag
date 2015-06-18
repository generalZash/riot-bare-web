<tabs>
</tabs>

<r-header>
  <div class='{ sticky: this.isSticky()}'>header area</div>

  this.sticky = false;

  window.addEventListener('scroll', function(event) {
    this.toggleSticky(event);
  }.bind(this));

  toggleSticky(event) {
    this.sticky = (this.root.getBoundingClientRect().top < 10);
    console.log('yolo');
    this.update();
  }

  isSticky() {
    return this.sticky
  }
</r-header>

<r-backdrop>
  <div class='backdrop'></div>

  <star-md class='star1'></star-md>
  <star-md class='star2'></star-md>
  <star-md class='star3'></star-md>
  <star-md class='star4'></star-md>
  <star-md class='star5'></star-md>
  <star-md class='star6'></star-md>

  <star-sm each={star, i in something}></div>

  // this is really stupid, isn't there a better way?
  this.something = [];
  for(var i=0; i<100; i++) {
    this.something.push(0);
  };
</r-backdrop>

<star-sm class='star-sm'>
  rand() {
    return Math.random() * 2000;
  }

  this.root.style.left = this.rand();
  this.root.style.top = this.rand();
</star-sm>

<star-md>
  <star-bits direction='up'></star-bits>
  <star-bits direction='down'></star-bits>
  <star-bits direction='left'></star-bits>
  <star-bits direction='right'></star-bits>

  // The root node can't access `opts`, which is really stupid, so we need to use this.root.className
  this.root.className = 'star-md ' + opts.class;
  console.log(opts);
</star-md>

<star-bits>
  this.root.className = 'star-bits ' + opts.direction;
</star-bits>

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

  this.tabs = [
    { title: 'Tab 1', ref: 'tab1', content: '1 content'},
    { title: 'Tab 2', ref: 'tab2', content: 'some other'},
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
