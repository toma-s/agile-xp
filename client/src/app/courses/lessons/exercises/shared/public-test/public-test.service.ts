import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class PublicTestService {

  private baseUrl = `${environment.baseUrl}public-test`;

  constructor(private http: HttpClient) { }

  createPublicTest(publicTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, publicTest);
  }

  getPublicTestsByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
