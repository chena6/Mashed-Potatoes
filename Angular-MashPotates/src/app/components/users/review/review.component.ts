import { Component, OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';

@Component({
  selector: 'app-review',
  templateUrl: './review.component.html',
  styleUrls: ['./review.component.css']
})
export class ReviewComponent implements OnInit {

  user: any;

  @Input()
  review: any;

  constructor(private http: Http, private userService: UserService, private refresh: RefreshService) { }

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => {
      this.user = user;
    });
  }

  deleteReview(idnum: number) {
    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
      data: idnum
    };

    this.http.post(environment.context + '/reviews/delete', body).subscribe(
      (successResponse) => {
        this.refresh.notify();
      }, (failResponse) => { });
  }
}
