import { Component, OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';
import { Comment } from '../../../entities/Comment';

import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-newcomment',
  templateUrl: './newcomment.component.html',
  styleUrls: ['./newcomment.component.css']
})
export class NewCommentComponent implements OnInit {

  closeResult: string;
  constructor(private http: Http, private userService: UserService, private refresh: RefreshService) {}
  user: any = null;

  @Input()
  movie: any;
  comment: Comment;

  ngOnInit () {
    this.userService.currentUser.subscribe(user => this.user = user);

    if (this.user) {
      this.comment = {
        id: 0,
        user: this.user,
        movie_id: this.movie.id,
        comments: '',
      };
    }
  }

  onSubmit() {
    this.http.post(environment.context + '/comments', this.comment).subscribe(
        (successResponse) => {
          this.refresh.notify();
          this.comment.comments = '';
        },  (failResponse) => { alert('Review submission failed.'); });
  }
}
