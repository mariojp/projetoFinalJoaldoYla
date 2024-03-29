import { ProvaDTO } from './../../model/DTO/provaDTO';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GenericService } from 'src/app/commons/generic.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProvaService extends GenericService {
  private relativePath = 'api/provas/';

  constructor(http: HttpClient) {
    super(http);
  }

  override save(prova: ProvaDTO): Observable<ProvaDTO> {
    return this.postMethod(prova, this.relativePath)
}
}
