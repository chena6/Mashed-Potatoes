import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';
import { UIRouterModule } from '@uirouter/angular';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import {AppComponent} from './app.component';
import {NavComponent} from './nav/nav.component';

// All components that are tied specifically to movies.
import { LandingPageComponent } from './components/landing/landing.component';
import { MoviePosterComponent } from './components/movies/movieposter/movieposter.component';
import { MovieDetailsComponent } from './components/movies/moviedetails/moviedetails.component';
import { MovieScoreComponent } from './components/movies/moviescore/moviescore.component';
import { CommentAreaComponent } from './components/movies/commentarea/commentarea.component';
import { ReviewAreaComponent } from './components/movies/reviewarea/reviewarea.component';
import { MovieSearchComponent } from './components/movies/moviesearch/moviesearch.component';
import { SearchResultsComponent } from './components/movies/searchresults/searchresults.component';

// All components that users create data for the database with.
import { CommentComponent } from './components/users/comment/comment.component';
import { ReviewComponent } from './components/users/review/review.component';
import { UserDetailsComponent } from './components/users/userdetails/userdetails.component';
import { NewCommentComponent } from './components/users/newcomment/newcomment.component';
import { AdminPanelComponent } from './components/users/adminpanel/adminpanel.component';

// Bootstrap-based components.
import { LoginModalComponent } from './components/bootstrap/loginmodal/loginmodal.component';
import { ReviewModalComponent } from './components/bootstrap/reviewmodal/reviewmodal.component';

// Shared Services
import { UserService } from './services/UserService.service';
import { RefreshService } from './services/RefreshService.service';

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
    MovieScoreComponent,
    CommentAreaComponent,
    ReviewAreaComponent,
    MovieSearchComponent,
    SearchResultsComponent,
    NewCommentComponent,

    CommentComponent,
    ReviewComponent,
    UserDetailsComponent,
    ReviewModalComponent,
    AdminPanelComponent,

    LoginModalComponent,
   ],
  providers: [
    UserService,
    RefreshService,
   ],
  bootstrap: [AppComponent]
})
export class AppModule { }
