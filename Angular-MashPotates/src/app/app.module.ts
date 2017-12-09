import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';
import { UIRouterModule } from '@uirouter/angular';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import {AppComponent} from './app.component';
import {NavComponent} from './nav/nav.component';

import { LandingPageComponent } from './components/landing/landing.component';
import { MoviePosterComponent } from './components/movieposter/movieposter.component';
import { MovieDetailsComponent } from './components/moviedetails/moviedetails.component';
import { CommentAreaComponent } from './components/commentarea/commentarea.component';
import { CommentComponent } from './components/comment/comment.component';
import { MovieScoreComponent } from './components/moviescore/moviescore.component';
import { ReviewAreaComponent } from './components/reviewarea/reviewarea.component';
import { ReviewComponent } from './components/review/review.component';
import { MovieSearchComponent } from './components/moviesearch/moviesearch.component';
import { SearchResultsComponent } from './components/searchresults/searchresults.component';

import { appRoutes } from './routes';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    NgbModule.forRoot(),
    RouterModule.forRoot(appRoutes),
    FormsModule
  ],
  declarations: [
    AppComponent,
    NavComponent,
    LandingPageComponent,
    MoviePosterComponent,
    MovieDetailsComponent,
    CommentAreaComponent,
    CommentComponent,
    MovieScoreComponent,
    ReviewAreaComponent,
    ReviewComponent,
    MovieSearchComponent,
    SearchResultsComponent,
   ],
  providers: [

   ],
  bootstrap: [AppComponent]
})
export class AppModule { }
