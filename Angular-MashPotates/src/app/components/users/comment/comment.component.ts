import { Component, OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css']
})
export class CommentComponent implements OnInit {

  user: any;

  @Input()
  comment: any;

  constructor(private http: Http, private userService: UserService, private refresh: RefreshService) { }

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => {
      this.user = user;
    });
  }

  deleteComment(idnum: number) {

    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
      data: idnum
    };

    this.http.post(environment.context + '/comments/delete', body).subscribe(
      (successResponse) => {
        this.refresh.notify();
      }, (failResponse) => { });
  }
}
