import { Component,  OnInit, Input, OnChanges } from '@angular/core';
import { environment } from '../../../../environments/environment';

@Component({
  selector: 'app-moviescore',
  templateUrl: './moviescore.component.html',
  styleUrls: ['./moviescore.component.css']
})
export class MovieScoreComponent implements OnInit, OnChanges {

  @Input()
  score: number;
  backgroundColor: string;

  ngOnInit() {
    this.ngOnChanges();
  }

  ngOnChanges() {
    this.score = Math.round(this.score * 10) / 10;
    console.log(this.score);
    this.backgroundColor = `rgb(${Math.trunc(((10 - this.score) / 10) * 255)}, ${Math.trunc((this.score / 10) * 255)}, 0)`;
  }

}
