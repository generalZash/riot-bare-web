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
  <star-md></star-md>
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

<star-md class='star-md'>
  /*setInterval(function() {
    this.root.className = 'star-md hidden';
    setTimeout(function() {
      this.root.className = 'star-md shooting-star';
    }.bind(this), Math.random() * 2000);
  }.bind(this), Math.random() * 5000 + 5000);*/
</star-md>

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
