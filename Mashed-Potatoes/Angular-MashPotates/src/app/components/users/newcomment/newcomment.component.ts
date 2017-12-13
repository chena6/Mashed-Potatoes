import { Component, OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';
import { Comment } from '../../../entities/Comment';

@Component({
  selector: 'app-newcomment',
  templateUrl: './newcomment.component.html',
  styleUrls: ['./newcomment.component.css']
})
export class NewCommentComponent implements OnInit {

  constructor(private http: Http, private userService: UserService, private refresh: RefreshService) {}
  user: any = null;

  @Input()
  movie: any;
  comment: Comment;

  ngOnInit () {
    this.comment = {
      id: 0,
      user: this.user,
      movie_id: this.movie.id,
      comments: '',
    };

    this.userService.currentUser.subscribe((user) => {
      console.log('init');
      this.user = user;

      this.comment = {
        id: 0,
        user: this.user,
        movie_id: this.movie.id,
        comments: '',
      };
    });
  }

  onSubmit() {

    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
      comment: this.comment
    };

    this.http.post(environment.context + '/comments', body).subscribe(
        (successResponse) => {
          this.refresh.notify();
          this.comment.comments = '';
        },  (failResponse) => { });
  }
}
