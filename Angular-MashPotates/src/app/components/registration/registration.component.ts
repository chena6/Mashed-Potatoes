import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Http } from '@angular/http';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  User = {
    username: '',
    password: '',
    email: '',
    firstname: '',
    lastname: ''
  };

  constructor(private router: Router, private http: Http) {
  }

  ngOnInit() {
  }

  Register() {
    this.http.post(environment.context + '/users/register', this.User).subscribe(
      (successResponse) => {
        alert('successfully registered');
      });

  }
}
