import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PublicFile } from './public-file.model';

@Injectable({
  providedIn: 'root'
})
export class PublicFileService {

  private baseUrl = `${environment.baseUrl}public-files`;

  constructor(private http: HttpClient) { }

  createPublicFile(publicFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, publicFile);
  }

  getPublicFilesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }

  updatePublicFile(id: number, publicFile: PublicFile): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, publicFile);
  }

  deletePublicFilesByExerciseId(exerciseId: number) {
    return this.http.delete(`${this.baseUrl}/${exerciseId}`, { responseType: 'text'});
  }
}
