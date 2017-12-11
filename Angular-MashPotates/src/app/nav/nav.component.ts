import { Component, OnInit } from '@angular/core';

import { UserService } from '../services/UserService.service';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.css']
})
export class NavComponent implements OnInit {

  constructor(private userService: UserService) {}
  user: any;

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => { this.user = user; });
  }
}
