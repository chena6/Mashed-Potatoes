import { Component,  OnInit, Input } from '@angular/core';
import { Movie } from '../../entities/Movie';

@Component({
  selector: 'app-poster',
  templateUrl: './movieposter.component.html',
  styleUrls: ['./movieposter.component.css']
})
export class MoviePosterComponent implements OnInit {

  @Input()
  movie: any;

  href: string;

  ngOnInit() {

    if (this.movie.poster === 'N/A') {
      this.movie.poster = 'http://movieseek.info/assets/images/imdbnoimage.jpg';
    }
    this.href = `/movies/${this.movie.id}`;

  }
}
