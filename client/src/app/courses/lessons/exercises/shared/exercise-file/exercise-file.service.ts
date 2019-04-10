import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ExerciseFileService {

  private baseUrl = 'http://www.st.fmph.uniba.sk:8080/~savkova3/agile-xp/api/exercise-files';

  constructor(private http: HttpClient) { }

  createExerciseFile(exerciseFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, exerciseFile);
  }

  getExerciseFilesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
