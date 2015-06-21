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

  <star-sm each={star, i in smallStars} width='{ parent.rand(window.screen.width)}' height='{ parent.rand(window.screen.height)}'>
  rand(max) {
    return Math.random() * max;
  }

  screenArea = window.screen.width * window.screen.height;
  starsNeeded = screenArea / 75000;//one star per 100px*100px area

  this.smallStars = [];
  for (var i=0; i<starsNeeded; i++) {
    this.smallStars.push(i);
  }/*
    var newStar = document.createElement('star-sm');
        this.root.appendChild(newStar);
        riot.mount(newStar, 'star-sm', {test: "3000"});
        this.starTimer();
      }
    }.bind(this), this.rand());
  }*/
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
