import { Component, OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';
import { Review } from '../../../entities/Review';

import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-newreview',
  templateUrl: './reviewmodal.component.html',
  styleUrls: ['./reviewmodal.component.css']
})
export class ReviewModalComponent implements OnInit {

  closeResult: string;
  constructor(private modalService: NgbModal, private http: Http, private userService: UserService, private refresh: RefreshService) {}
  user: any = null;

  @Input()
  movie: any;
  review: Review;

  ngOnInit () {
    this.userService.currentUser.subscribe(user => this.user = user);

    if (this.user) {
      this.review = {
        id: 0,
        user: this.user,
        movie_id: this.movie.id,
        review: '',
        score: 10
      };
    }
  }

  open(content) {
    this.modalService.open(content).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return  `with: ${reason}`;
    }
  }

  onSubmit() {
    this.http.post(environment.context + '/reviews', this.review).subscribe(
        (successResponse) => {
          this.refresh.notify();
          this.review = {
            id: 0,
            user: this.user,
            movie_id: this.movie.id,
            review: '',
            score: 10
          };
        },  (failResponse) => { alert('Review submission failed.'); });
  }
}