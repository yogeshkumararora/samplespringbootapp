package io.github.parj.hello;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.availability.AvailabilityChangeEvent;
import org.springframework.boot.availability.LivenessState;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;



@Component
@RestController
public class MakeItFailController {

    Logger logger = LoggerFactory.getLogger(MakeItFailController.class);

    private final ApplicationEventPublisher eventPublisher;

    public MakeItFailController(ApplicationEventPublisher eventPublisher) {
        this.eventPublisher = eventPublisher;
    }

    @RequestMapping(value = "/letitgo", method = { RequestMethod.POST, RequestMethod.GET } )
    public ResponseEntity<?> failIT() {
        logger.info("Causing a liveness failure");
        AvailabilityChangeEvent.publish(this.eventPublisher, new Exception("Failure test"), LivenessState.BROKEN);
        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
