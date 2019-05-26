import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BugsNumberService {

  private baseUrl = `${environment.baseUrl}bugs-number`;

  constructor(private http: HttpClient) { }

  saveBugsNumber(exerciseId: number, bugsNumber: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/${exerciseId}/${bugsNumber}`);
  }

  getBugsNumberByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }

}
