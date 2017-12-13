import { Component,  OnInit } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'app';
  searchResults: Array<any>;

  constructor() { }

  receiveSearch($event) {
    this.searchResults = $event;
  }

  ngOnInit()  {

  }

  change() {

  }

  clearSearch() {
    this.searchResults = null;
  }
}
