import { Component,  OnInit, Input } from '@angular/core';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-moviescore',
  templateUrl: './moviescore.component.html',
  styleUrls: ['./moviescore.component.css']
})
export class MovieScoreComponent implements OnInit {

  @Input()
  score: number;
  backgroundColor: string;

  ngOnInit() {
    // Change background color of the score element based on the value of the score.
    this.score = Math.trunc(this.score * 10) / 10;
    this.backgroundColor = `rgb(${Math.trunc(((10 - this.score) / 10) * 255)}, ${Math.trunc((this.score / 10) * 255)}, 0)`;
  }

}
