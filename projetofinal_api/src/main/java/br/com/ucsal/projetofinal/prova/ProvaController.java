package br.com.ucsal.projetofinal.prova;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/provas")
public class ProvaController {

    private final ProvaService provaService;

    public ProvaController(ProvaService provaService) {
        this.provaService = provaService;
    }

    @GetMapping("/")
    public ResponseEntity<List<Prova>> lista() {
        List<Prova> provas = provaService.listar();
        return ResponseEntity.ok().body(provas);
    }

    @GetMapping("/{id}")
    public ResponseEntity<List<Prova>> listarPorIdProva(@PathVariable Long id) {
        List<Prova> provas = provaService.listarPorIdProva(id);
        if (provas.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.ok().body(provas);
    }

    @PostMapping("/")
    public ResponseEntity<?> inserir(@RequestBody @Valid ProvaRequestDto provaRequestDto) {
        try {
            return ResponseEntity.ok().body(new ProvaResponseDto(provaService.inserir(provaRequestDto)));
        } catch (Exception ex) {
            return ResponseEntity.badRequest().build();
        }
    }
}
