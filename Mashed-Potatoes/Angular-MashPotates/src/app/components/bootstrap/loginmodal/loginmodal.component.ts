import { Component, OnInit } from '@angular/core';
import { Http } from '@angular/http';
import { Router } from '@angular/router';
import { environment } from '../../../../environments/environment';
import { UserService } from '../../../services/UserService.service';
import { Credentials } from '../../../entities/Credentials';

import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-login-modal',
  templateUrl: './loginmodal.component.html',
  styleUrls: ['./loginmodal.component.css']
})
export class LoginModalComponent implements OnInit {

  closeResult: string;
  constructor(private router: Router, private modalService: NgbModal, private http: Http, private userService: UserService) {}
  user: any = null;
  modalReference: any;

  profilehref: string;

  credentials: Credentials = {
    username: '',
    password: ''
  };

  ngOnInit () {

    this.http.get(environment.context + '/users/login').subscribe(
        (successResponse) => {
          if (successResponse.text()) {
            this.user = successResponse.json();
          }
    },  (failResponse) => { });

    this.userService.currentUser.subscribe(user => this.user = user);
  }

  open(content) {
    this.modalReference = this.modalService.open(content);
    this.modalReference.result.then((result) => {
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
    this.http.post(environment.context + '/users/login', this.credentials).subscribe(
        (successResponse) => {
          this.user = successResponse.json();
          this.user.password = this.credentials.password;
          this.credentials.username = '';
          this.credentials.password = '';
          this.profilehref = `/users/${this.user.id}`;
          this.userService.setUser(this.user);
          this.modalService.open(null).close();
          this.modalReference.close();
    },  (failResponse) => {});
  }

  logout() {
    this.user = null;
    this.userService.setUser(this.user);
    this.http.get(environment.context + '/users/logout').subscribe(() => { this.router.navigate(['/home']); }, () => {});
  }

}
